all : targetwithvar novarhere

# Set environment variable
ifndef FOOVAR
targetwithvar: export FOOVAR=testing123
endif
targetwithvar:
	@echo ==== In the 'targetwithvar' recipe. ====
	@echo FOOVAR should be set to \'testing123\' unless it was set in the calling shell.
	@echo Actual value of FOOVAR: \'$$FOOVAR\'

novarhere:
	@echo ==== In the 'novarhere' recipe. ====
	@echo FOOVAR should be empty for this rule, unless it was set in the calling shell.
	@echo Actual value of FOOVAR: \'$$FOOVAR\'

.PHONY: all targetwithvar novarhere

