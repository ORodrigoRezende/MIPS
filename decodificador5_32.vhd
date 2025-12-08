library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodificador5_32 is port (
    A : in  STD_LOGIC_VECTOR (4 downto 0);
    E : in  STD_LOGIC;
    S : out  STD_LOGIC_VECTOR (0 to 31)
);
end decodificador5_32;

architecture Behavioral of decodificador5_32 is
    component decodificador2_4 is port (
        A : in  STD_LOGIC_VECTOR (1 downto 0);
        E : in  STD_LOGIC;
        S : out  STD_LOGIC_VECTOR (0 to 3)
    );
    end component;

    signal sPrimeiraCamada : STD_LOGIC_VECTOR (0 to 1);
    signal sSegundaCamada : STD_LOGIC_VECTOR (0 to 7);

begin
    sPrimeiraCamada(0) <= not A(4) and E;
    sPrimeiraCamada(1) <= A(4) and E;

    gen1 : for i in 0 to 1 generate
        DC2_4_1 : decodificador2_4 port map (
            A(1 downto 0) => A(3 downto 2),
            E => sPrimeiraCamada(i),
            S => sSegundaCamada(i*4 to i*4 + 3)
        );
    end generate;

    gen2 : for j in 0 to 7 generate
        DC2_4_2 : decodificador2_4 port map (
            A(1 downto 0) => A(1 downto 0),
            E => sSegundaCamada(j),
            S => S(j*4 to j*4 + 3)
        );
    end generate;
end Behavioral;
    
