`include "src/nRisc.v"
`include "src/MemoriaDados.v"
`include "src/MemoriaInstrucao.v"

module SimulacaoGeral;

    reg Clock, Reset;

    reg[15:0] counter;

    /* Memoria de Instrucao */
    wire[7:0] InstrucaoLida; // sai da mem instr

    /* Memoria de Dados */
    wire[7:0] EnderecoDados, // entra na mem dados 
        DadoEscrito, // entra na mem dados
        DadoLido; // sai da mem dados

    MemoriaDados memoriaDados(.Endereco(EnderecoDados), 
                              .DadoEscr(DadoEscrito), 
                              .DadoLido(DadoLido), 
                              .MenWrite(nrisc.MemWrite), 
                              .MenRead(nrisc.MemRead), 
                              .Clock(Clock)
                             );

    MemoriaInstrucao memoriaInstrucao(.Endereco(nrisc.pc1.PC), 
                                      .Instrucao(InstrucaoLida), 
                                      .Clock(Clock)
                                     );

    nRisc nrisc(.Reset(Reset), 
                .Clock(Clock),
                .InstrucaoLida(InstrucaoLida), 
                .EnderecoDados(EnderecoDados), 
                .DadoEscrito(DadoEscrito), 
                .DadoLido(DadoLido)
               );
    
    initial begin
        nrisc.pc1.PC = 8'b00000000;
        Clock = 1;
        Reset = 0;
        counter = 10;
        
        $readmemb("assets/dados.txt", memoriaDados.Dados); //Leitura dos dados
        $readmemb("assets/instrucoes.txt", memoriaInstrucao.Instrucoes); // leitura das instrucoes
    end
    
    // initial 
    //     $monitor("%0d | pc=%b | i=%b| sp=%b | rr=%b | r0=%b | r1=%b | r2=%b | r3=%b | ra=%b | %0d",
    //            counter, 
    //            nrisc.pc1.PC,
    //            InstrucaoLida,
    //            nrisc.bancoDeRegistradores.BR[3'b111],
    //            nrisc.bancoDeRegistradores.BR[3'b101],
    //            nrisc.bancoDeRegistradores.BR[3'b000],
    //            nrisc.bancoDeRegistradores.BR[3'b001],
    //            nrisc.bancoDeRegistradores.BR[3'b010],
    //            nrisc.bancoDeRegistradores.BR[3'b011],
    //            nrisc.bancoDeRegistradores.BR[3'b110],
    //            Clock);
    // 

    always begin
        if(memoriaInstrucao.Instrucoes[nrisc.PCOut] == 8'b00000000) begin
            $display(" ");
            $display("Maior: %b | Menor: %b",nrisc.bancoDeRegistradores.BR[3'b010], nrisc.bancoDeRegistradores.BR[3'b011]);
            $finish;
        end
         #1; Clock = ~Clock;
    end

    always@(posedge Reset) begin
        nrisc.pc1.PC = 8'b00000000;
    end

    always@(posedge Clock) begin
        counter = counter + 1;
        // $display(" ");
    end
	
endmodule