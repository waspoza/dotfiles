function tide_shorten_path --description "Tide-style path shortening (no cache)"
    set -l cwd (pwd)
    set -l home ~

    # Handle home directory replacement
    if string match -q "$home/*" "$cwd"
        set cwd "~"(string sub -s (math (string length $home) + 1) "$cwd")
    else if [ "$cwd" = "$home" ]
        set cwd "~"
    end

    # Split path into segments
    set -l segments
    for seg in (string split / "$cwd")
        if [ -n "$seg" ]
            set -a segments "$seg"
        end
    end

    # Too few segments to shorten
    if [ (count $segments) -le 2 ]
        string join / $segments
        return
    end

    # Process segments
    set -l result_segments
    for i in (seq (count $segments))
        set -l segment $segments[$i]

        # Keep first and last full
        if [ $i -eq 1 ] || [ $i -eq (count $segments) ]
            set -a result_segments "$segment"
            continue
        end

        # Build real parent path for sibling checking
        set -l parent_parts
        if [ $i -gt 1 ]
            # Collect all segments up to current one
            for j in (seq 1 (math $i - 1))
                if [ -n "$segments[$j]" ]
                    set -a parent_parts "$segments[$j]"
                end
            end
        end

        # Convert display path to real filesystem path
        set -l real_parent
        if [ "$segments[1]" = "~" ]
            # Handle ~/... paths
            if [ (count $parent_parts) -eq 0 ]
                set real_parent "$home"
            else if [ "$parent_parts[1]" = "~" ]
                if [ (count $parent_parts) -eq 1 ]
                    set real_parent "$home"
                else
                    set -l relative_parts $parent_parts[2..-1]
                    set real_parent "$home/"(string join / $relative_parts)
                end
            else
                set real_parent (string join / $parent_parts)
            end
        else
            # Absolute path
            if [ (count $parent_parts) -eq 0 ]
                set real_parent "/"
            else
                set real_parent "/"(string join / $parent_parts)
            end
        end

        # Get sibling directories at this level
        set -l siblings
        if [ -d "$real_parent" ]
            # Simple method
            set siblings (command ls -d "$real_parent"/*/ 2>/dev/null | string replace -r '.*/' '' | string trim -r -c /)
        end

        # Find shortest unique prefix
        if [ (count $siblings) -gt 0 ]
            # Find shortest unique prefix
            set -l found_prefix "$segment"  # Default to full segment
            for len in (seq 1 (string length "$segment"))
                set -l prefix (string sub -l $len "$segment")
                set -l is_unique true

                foreach sibling in $siblings
                    if [ "$sibling" != "$segment" ] && [ (string sub -l $len "$sibling") = "$prefix" ]
                        set is_unique false
                        break
                    end
                end

                if [ "$is_unique" = true ]
                    set found_prefix "$prefix"
                    break
                end
            end

            set -a result_segments "$found_prefix"
        else
            # No siblings found, just use first character
            set -a result_segments (string sub -l 1 "$segment")
        end
    end

    # Join and return result
    string join / $result_segments
end

function tide_path
    tide_shorten_path
end
