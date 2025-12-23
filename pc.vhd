library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc is port(
    D: in STD_LOGIC_VECTOR(31 downto 0);
    Inicializacao,CLK: in STD_LOGIC;
    S : out STD_LOGIC_VECTOR(31 downto 0)
);
end pc;

architecture behavioral of pc is
    component flipflopd_subida is port (
        D     : in  STD_LOGIC;
        Clear : in  STD_LOGIC;
        Preset : in  STD_LOGIC;
        Enable : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
    end component;

begin 

    gen1: for i in 0 to 21 generate
        FF: flipflopd_subida port map (
            D => D(i),
            Clear => Inicializacao,
            Preset => '0',
            Enable => '1',
            CLK => CLK,
            Q => S(i)
        );
    end generate;

    FF2 : flipflopd_subida port map (
        D => D(22),
        Clear => '0',
        Preset => Inicializacao,
        Enable => '1',
        CLK => CLK,
        Q => S(22)
    );

    gen2: for j in 23 to 31 generate
        FF3: flipflopd_subida port map (
            D => D(j),
            Clear => Inicializacao,
            Preset => '0',
            Enable => '1',
            CLK => CLK,
            Q => S(j)
        );
    end generate;
end behavioral;