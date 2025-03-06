set -l tmp (mktemp -d)
echo "Cloning dirvenv to $tmp"
git clone -q https://github.com/cuducos/dirvenv.fish "$tmp"
for dir in conf.d functions
    set -l source "$tmp/$dir/dirvenv.fish"
    set -l target "$__fish_config_dir/$dir/"
    echo "Copying $source to $target"
    cp "$source" "$target"
end
echo "Cleaning up $tmp"
rm -rf $tmp
