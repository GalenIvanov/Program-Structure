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
    spec: copy spec-of :fn

	parse spec [
 		any args  ; main func arity
		any [ refs some args | skip ]  ; refinements args
		stop
	]
    n
]


{
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