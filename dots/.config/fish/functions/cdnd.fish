function cdnd
    if test -n "$argv[1]"
        mkdir -p "$argv[1]"; and cd "$argv[1]"
    else
        echo "Usage: cdnd <directory_name>"
    end
end
