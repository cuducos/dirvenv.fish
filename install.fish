for dir in conf.d functions
    set -l source "$dir/dirvenv.fish" 
    set -l target  "$__fish_config_dir/$dir/"
    echo "Copying $source to $target"
    cp "$source" "$target"
end
