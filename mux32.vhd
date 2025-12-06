library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32 is port(
    E : in STD_LOGIC_VECTOR(0 TO 31);
    SEL : in STD_LOGIC_VECTOR(4 DOWNTO 0);
    S : out STD_LOGIC
);
end mux32;

architecture Behavioral of mux32 is
    component mux2 is port(
        E : in STD_LOGIC_VECTOR(0 TO 1);
        SEL : in STD_LOGIC;
        S : out STD_LOGIC
    );
    end component;

    component mux4 is port(
        E : in STD_LOGIC_VECTOR(0 TO 3);
        SEL : in STD_LOGIC_VECTOR(1 DOWNTO 0);
        S : out STD_LOGIC
    );
    end component;

    signal SCamada1 : STD_LOGIC_VECTOR(0 TO 7);
    signal SCamada2 : STD_LOGIC_VECTOR(0 TO 1);

begin
    gen1 : for i in 0 to 7 generate
        M: mux4 port map (
            E => E(4*i TO 4*i+3),
            SEL => SEL(1 DOWNTO 0),
            S => Scamada1(i)
        );
    end generate;

    gen2 : for j in 0 to 1 generate
        M: mux4 port map (
            E => SCamada1(4*j TO 4*j+3),
            SEL => SEL(3 DOWNTO 2),
            S => Scamada2(j)
        );
    end generate;

    Mfinal: mux2 port map (
        E => SCamada2(0 TO 1),
        SEL => SEL(4),
        S => S
    );

end Behavioral;
    