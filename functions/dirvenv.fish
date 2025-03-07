function find_venv -d "Recursively looks for virtualenvs up in the directory tree"
    set -f dir (pwd)
    if test -n "$DIRVENV_IGNORE"
        for ignore in (string split "," "$DIRVENV_IGNORE")
            set -l cleaned (string trim "$ignore")
            if string match -r "^$cleaned" "$dir"
                return 0
            end
        end
    end
    set -f dir (pwd)
    set -f venvs (string length -q "$DIRVENV_DIRS" && echo "$DIRVENV_DIRS" || echo ".venv,venv")
    while test "$dir" != /
        for venv in (string split "," "$venvs")
            set -l cleaned (string trim "$venv")
            if test -d "$dir/$cleaned"
                echo "$dir/$cleaned"
                return 0
            end
        end
        set -f dir (dirname $dir)
    end
end

function dirvenv -d "Toggles the virtualenv detected by `dirvenv` on and off"
    set -f venv (find_venv)
    set -f activated (string join / (path normalize (string length -q "$TMPDIR" && echo "$TMPDIR" || echo /tmp) ) ".direnv")
    if set -q VIRTUAL_ENV
        if test -z "$venv" || test "$venv" != "$VIRTUAL_ENV"
            if test -e $activated
                if string match -q "$fish_pid:$VIRTUAL_ENV" (cat "$activated")
                    deactivate
                    cat "$activated" | string match -v "$fish_pid:$VIRTUAL_ENV" >$activated
                end
            end
        else
            return 0
        end
    end
    if test -n "$venv"
        set -l activate "$venv/bin/activate.fish"
        if test -f "$activate"
            source "$activate"
            echo "$fish_pid:$VIRTUAL_ENV" >>"$activated"
        end
    end
end
