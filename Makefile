run:
	@ echo "Running Processor"
	@ iverilog SimulacaoGeral.v -o bin/processor && ./bin/processor