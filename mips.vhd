library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.tipo.all;

entity mips is port(
    Clk,Inicializar : in STD_LOGIC;
    DebugEndereco : in STD_LOGIC_VECTOR(31 downto 0);
    DebugPalavra : out STD_LOGIC_VECTOR(31 downto 0)
);

end mips;

architecture Behavioral of mips is
    component bancoderegistradores  is port (
        CLK     : in  std_logic;
        regWrite: in  std_logic;
        readReg1: in  std_logic_vector(4 downto 0);
        readReg2: in  std_logic_vector(4 downto 0);
        writeReg: in  std_logic_vector(4 downto 0);
        writeData: in  std_logic_vector(31 downto 0);
        readData1: out tipo_palavra;
        readData2: out tipo_palavra
    );
    end component;

    component somador32  is port(
	A : in std_logic_vector(31 downto 0);
	B : in std_logic_vector(31 downto 0);
	Result :out std_logic_vector(31 downto 0)
	);
    end component;

    component mux2_5b  is port(
    A : in STD_LOGIC_VECTOR(0 TO 4);
    B : in STD_LOGIC_VECTOR(0 TO 4);
    SEL : in STD_LOGIC;
    S : out STD_LOGIC_VECTOR(0 TO 4)
    );
    end component;

    component mux2_32b is port(
        A : in STD_LOGIC_VECTOR(31 downto 0);
        B : in STD_LOGIC_VECTOR(31 downto 0);
        SEL : in STD_LOGIC;
        S : out STD_LOGIC_VECTOR(31 downto 0)
    );
    end component;

    component deslocador  is port (
    E : in  STD_LOGIC_VECTOR (31 downto 0);
    S : out  STD_LOGIC_VECTOR (31 downto 0)
    );
    end component;
 
    component extensorsinal is port (
    E : in  STD_LOGIC_VECTOR (15 downto 0);
    S : out  STD_LOGIC_VECTOR (31 downto 0)
    );
    end component;

    component pc is port(
    D: in STD_LOGIC_VECTOR(31 downto 0);
    Inicializacao,CLK: in STD_LOGIC;
    S : out STD_LOGIC_VECTOR(31 downto 0)
    );
    end component;

    component ula32 is port(
    Ainvet  : in  STD_LOGIC;
    Binvert : in  STD_LOGIC;
    A       : in  STD_LOGIC_VECTOR (31 downto 0);
    B       : in  STD_LOGIC_VECTOR (31 downto 0);
    Op      : in  STD_LOGIC_VECTOR (1 downto 0);
    R       : out STD_LOGIC_VECTOR (31 downto 0);
    Zero    : out STD_LOGIC
    );
    end component;

    component unidadecontroleula is port(
    Funct : in STD_LOGIC_VECTOR(5 downto 0);
    ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
    AInvert : out STD_LOGIC;
    BInvert : out STD_LOGIC;
    Op: out STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;

    component unidadecontrole is port (
    Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
    RegDst : out STD_LOGIC;
    ALUSrc : out STD_LOGIC;
    MemtoReg : out STD_LOGIC;
    RegWrite : out STD_LOGIC;
    MemRead : out STD_LOGIC;
    MemWrite : out STD_LOGIC;
    Branch : out STD_LOGIC;
    ALUOp : out STD_LOGIC_VECTOR (1 downto 0);
    Jump : out STD_LOGIC
    );
    end component;

    component memDados is port (
		DadoLido : out std_logic_vector (31 downto 0);
		DadoEscrita : in std_logic_vector (31 downto 0);
		Endereco : in std_logic_vector (31 downto 0);
		EscreverMem : in std_logic;
		Clock : in std_logic;
		LerMem : in std_logic;
		DebugEndereco : in std_logic_vector(31 downto 0);
		DebugPalavra : out std_logic_vector(31 downto 0)
    );
    end component;

    component memInstrucoes is port (
		Endereco : in std_logic_vector(31 downto 0);
		Palavra : out std_logic_vector(31 downto 0)
	);
    end component;

    signal SPC,SMenInstrucao,SMux3,SReadData1,SReadData2,SExtensor,SMux2,SALUResult,SReadDataMemory,SAdd4,SShiftLeft1,SShiftLeft2,SALUResultADD,SMUX4,SMUX5 : tipo_palavra;
	signal SRegDst,SRegWrite,SALUSrc,SZero,SMenWrite,SMenRead,SMentoReg,SBranch,SAND,SJump, SAinvert,SBinvert: std_logic;
	signal SMux1: std_logic_vector(4 downto 0);  
	signal SALUOP,SALUControl : std_logic_vector(1 downto 0);

begin
    -- PC
    PC1 : pc port map (
        D => SMUX5,
        Inicializacao => Inicializar,
        CLK => Clk,
        S => SPC
    );

    --Memoria Intrução 
    MemInstrucao1 : memInstrucoes port map (
        Endereco => SPC,
        Palavra => SMenInstrucao
    );

    --Banco de Registradores
    BancoDeRegistradores1 : bancoderegistradores port map(
        CLK => Clk,
        regWrite => SRegWrite,
        readReg1 => SMenInstrucao(25 downto 21),
        readReg2 => SMenInstrucao(20 downto 16),
        writeReg => SMux1,
        writeData => SMUX3,
        readData1 => SReadData1,
        readData2 => SReadData2
    );

    -- MUX Banco de Registradores
    MUX1 : mux2_5b port map(
        A => SMenInstrucao(20 downto 16),
        B => SMenInstrucao(15 downto 11),
        SEL => SRegDst,
        S => SMux1
    );

    -- Extensor de Sinal
    ExtensorDeSinal1 : extensorsinal port map (
        E => SMenInstrucao(15 downto 0),
        S => SExtensor
    );

    -- MUX ULA
    MUX2 : mux2_32b port map (
        A => SReadData2,
        B => SExtensor,
        SEL => SALUSrc,
        S => SMux2
    );

    -- Unidade de Controle da ULA
    UnidadeControleULA1 : unidadecontroleula port map (
        Funct => SMenInstrucao(5 downto 0),
        ALUOp => SALUOP,
        AInvert => SAinvert,
        BInvert => SBinvert,
        Op => SALUControl
    );

    -- ULA
    ULA1 : ula32 port map (
        Ainvet => SAinvert,
        Binvert => SBinvert,
        A => SReadData1,
        B => SMux2,
        Op => SALUControl,
        R => SALUResult,
        Zero => SZero
    );

    -- Memória de Dados
    MemDados1 : memDados port map (
        DadoLido => SReadDataMemory,
        DadoEscrita => SReadData2,
        Endereco => SALUResult,
        EscreverMem => SMenWrite,
        Clock => Clk,
        LerMem => SMenRead,
        DebugEndereco => DebugEndereco,
        DebugPalavra => DebugPalavra
    );

    -- MUX Memória de Dados
    MUX3 : mux2_32b port map (
        A => SALUResult,
        B => SReadDataMemory,
        SEL => SMentoReg,
        S => SMUX3
    );

    -- Unidade de controle principal
    UnidadeDeControle1 : unidadecontrole port map (
        OpCode => SMenInstrucao(31 downto 26),
        RegDst => SRegDst,
        RegWrite => SRegWrite,
        ALUSrc => SALUSrc,
        MemWrite => SMenWrite,
        MemRead => SMenRead,
        MemtoReg => SMentoReg,
        Branch => SBranch,
        ALUOp => SALUOP,
        Jump => SJump
    );

    -- Deslocador parte de intrução
    Deslocador1 : deslocador port map (
        E(25 downto 0) => SMenInstrucao(25 downto 0),
        E(31 downto 26) => "000000",
        S => SShiftLeft1
    );

    -- Deslocador de 2 bits depois do extensor de sinal 
    Deslocaodr2 : deslocador port map (
        E => SExtensor,
        S => SShiftLeft2
    );

    --MUX que a entrada é a AND
    MUX4 : mux2_32b port map (
        A => SAdd4,
        B => SALUResultADD,
        SEL => SAND,
        S => SMUX4
    );

    -- Ultimo MUX
    MUX5 : mux2_32b port map (
        A => SMUX4,
        B => SShiftLeft1,
        SEL => SJump,
        S => SMUX5
    );

    -- Somador PC +4
    Somador1 : somador32 port map (
        A => SPC,
        B => "00000000000000000000000000000100",
        Result => SAdd4
    );

    -- Somador desclocador + PC+4
    Somador2 : somador32 port map (
        A => SShiftLeft2,
        B => SAdd4,
        Result => SALUResultADD
    );

    SAND <= SBranch and SZero;
end Behavioral;

