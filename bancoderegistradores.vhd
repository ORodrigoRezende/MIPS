library IEEE;
use IEEE.std_Logic_1164.all;

library work;
use work.tipo.all;

entity bancoderegistradores is
    port (
        CLK     : in  std_logic;
        regWrite: in  std_logic;
        readReg1: in  std_logic_vector(4 downto 0);
        readReg2: in  std_logic_vector(4 downto 0);
        writeReg: in  std_logic_vector(4 downto 0);
        writeData: in  std_logic_vector(31 downto 0);
        readData1: out tipo_palavra;
        readData2: out tipo_palavra
    );
end bancoderegistradores;

architecture Behavioral of bancoderegistradores is 

    component decodificador5_32 is port (
        A : in  STD_LOGIC_VECTOR (4 downto 0);
        E : in  STD_LOGIC;
        S : out  STD_LOGIC_VECTOR (0 to 31)
    );
    end component;

    component registrador32 is port(
        D : in  STD_LOGIC_VECTOR (31 downto 0);
        Clear : in  STD_LOGIC;
        Preset : in  STD_LOGIC;
        Enable : in  STD_LOGIC;
        CLK : in  STD_LOGIC;
        Q : out  STD_LOGIC_VECTOR (31 downto 0)
    );
    end component;

    component mux32x32 is port (
        E : in tipo_vetor_de_palavras(0 to 31);
		Sel : in std_logic_vector(4 downto 0);
		Saida : out tipo_palavra
    );
    end component;
    signal sinalEscrita : STD_LOGIC_VECTOR (0 to 31);
    signal bancoInterno : tipo_vetor_de_palavras(0 to 31);

begin
    decodificadorEscrita : decodificador5_32 port map (
        A => writeReg,
        E => regWrite,
        S => sinalEscrita
    );

    reg0 : registrador32 port map (
        D => x"00000000",
        Clear => '1',
        Preset => '0',
        Enable => '0',
        CLK => CLK,
        Q => bancoInterno(0)
    );

    gen_registradores: for i in 1 to 31 generate
        reg : registrador32 port map (
            D => writeData,
            Clear => '0',
            Preset => '0',
            Enable => sinalEscrita(i),
            CLK => CLK,
            Q => bancoInterno(i)
        );
    end generate;

    muxLeitura1 : mux32x32 port map (
        E => bancoInterno,
        Sel => readReg1,
        Saida => readData1
    );

    muxLeitura2 : mux32x32 port map (
        E => bancoInterno,
        Sel => readReg2,
        Saida => readData2
    );

end Behavioral;