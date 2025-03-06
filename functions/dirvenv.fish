function find_venv -d "Recursively looks for virtualenvs up in the directory tree"
    set -f dir (pwd)
    while test "$dir" != /
        for venv in .venv venv
            if test -d "$dir/$venv"
                echo "$dir/$venv"
                return 0
            end
        end
        set -f dir (dirname $dir)
    end
end


function dirvenv -d "Toggles the virtualenv detected by `dirvenv` on and off"
    set -f activated (string join / (path normalize (string length -q "$TMPDIR" && echo $TMPDIR || echo /tmp) ) ".direnv.$fish_pid")
    set -f venv (find_venv)
    if set -q VIRTUAL_ENV
        if test -z "$venv" && test -e $activated
            if string match -q "$VIRTUAL_ENV" (cat "$activated")
                deactivate
                rm "$activated"
            end
        end
    else
        set -l activate "$venv/bin/activate.fish"
        if test -n "$venv" && test -f "$activate"
            source "$activate"
            echo "$VIRTUAL_ENV" >"$activated"
        end
    end
end
