Red [
    Title: "Program structure"
    Author: "Galen Ivanov"
    ;Needs: 'View
]

arity: function [
    {Returns the arity of a specific function call,
     including the arguments of the refinements}
    f [word! any-block!]
][
    args: [opt string! [word! | lit-word! | get-word!] (n: n + 1) opt block! opt string!] 
    stop: [quote return: | quote /local | quote /extern | end]
    fn: get either path? :f[f/1][f]
    refs: copy []
    if path? :f [
        foreach r next :f [
            append refs compose [quote (to refinement! r) |]
        ]
        take/last refs
    ]
    n: 0
    parse spec-of :fn [
        any args  ; main func arity
        any [ refs some args | skip ]  ; refinements args
        stop
    ]
    n
]

extract-dummy-funcs: function [
    {Identifies and extracts user-defined functions from a block into a map.
    Only [set-word!] and [qoute set any-word!] are recognized as function names.
    Only literal blocks are recognized as function specs.
    }
    src-block [block!] {a block containing loaded source}
][
    f-map: copy #()
    rule: [(b: copy [])
            fn-name (append b to-set-word name)
            set t a-func (append b t)
            copy t block! (append b t append/only b [])]
    fn-name: [set name set-word! | quote set set name any-word!]
    a-func: [quote func | quote function | quote has]
    parse src-block [any [any [not rule skip] rule (put f-map name b)]]
    f-map
]

src: [
    a: 10
    b: "Some text"
    sq: function [x][x * x]
    a-block: [y + z * (zz)]
    zz: 10
    set 'inc func[y z] compose a-block
    {goodbye}
]


probe fns: extract-dummy-funcs src


{  ; TESTS
print arity 'bind

foreach fn [
    copy/part
    replace/all/case
    foreach
    find/last
    print
    pad/left/with
    take/part/last
    extract/index/into
    find/part/skip/with
][
    print [form fn "->" arity :fn]
]
}
