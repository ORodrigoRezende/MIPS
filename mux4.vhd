library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4 is
    Port ( E : in STD_LOGIC_VECTOR(0 TO 3);
           SEL : in STD_LOGIC_VECTOR(1 DOWNTO 0);
           S : out STD_LOGIC);
end mux4;

architecture Behavioral of mux4 is
    component mux2
        Port ( E : in STD_LOGIC_VECTOR(0 TO 1);
               SEL : in STD_LOGIC;
               S : out STD_LOGIC);
    end component;

    signal S0, S1 : STD_LOGIC;
begin
        M1: mux2 port map (
            E => E(0 TO 1),
            SEL => SEL(0),
            S => S0
        );
        M2: mux2 port map (
            E => E(2 TO 3),
            SEL => SEL(0),
            S => S1
        );

        S <= (S0 AND NOT SEL(1)) OR (S1 AND SEL(1));

end Behavioral;