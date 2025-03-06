for dir in conf.d functions
    set -l target "$__fish_config_dir/$dir/dirvenv.fish"
    echo "Removing $target"
    rm "$target"
end
