library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador32 is
	port(
	A : in std_logic_vector(31 downto 0);
	B : in std_logic_vector(31 downto 0);
	Result :out std_logic_vector(31 downto 0)
	);
end somador32;

architecture Behavioral of somador32 is
	component somadorcompleto is 
	port(
		A : in STD_LOGIC;
        B : in STD_LOGIC;
        Vem1 : in STD_LOGIC;
        S : out STD_LOGIC;
        Vai1 : out STD_LOGIC
	);
	end component;

	signal Vai1Vetor: std_logic_vector(0 to 32);

begin
	Vai1Vetor(0) <= '0';

	genPrimeiraCamada : for i in 0 to 31 generate
	somadorcompleto1 : somadorcompleto port map(
	A => A(i),
	B => B(i),
	Vem1 => Vai1Vetor(i),
	S => Result(i),
	Vai1 => Vai1Vetor(i+1)
	);
	end generate;

end Behavioral;