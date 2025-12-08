library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidadecontroleula is port(
    Funct : in STD_LOGIC_VECTOR(5 downto 0);
    ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
    AInvert : out STD_LOGIC;
    BInvert : out STD_LOGIC;
    Op: out STD_LOGIC_VECTOR(1 downto 0)
);
end unidadecontroleula;

architecture behavioral of unidadecontroleula is
begin
    process(Funct, ALUOp)
    begin
        if    ALUOp = "00" then
            AInvert <= '0';
            BInvert <= '0';
            Op      <= "10";
        elsif ALUOp = "01" then
            AInvert <= '0';
            BInvert <= '1';
        elsif ALUOp = "10" then
            if    Funct = "100000" then
                AInvert <= '0';
                BInvert <= '0';
                Op      <= "10";
            elsif Funct = "100100" then
                AInvert <= '0';
                BInvert <= '0';
                Op      <= "00";
            elsif Funct = "100111" then
                AInvert <= '1';
                BInvert <= '1';
                Op      <= "00";
            elsif Funct = "100101" then
                AInvert <= '0';
                BInvert <= '0';
                Op      <= "01";
            elsif Funct = "101010" then
                AInvert <= '0';
                BInvert <= '1';
                Op      <= "11";
            elsif Funct = "100010" then
                AInvert <= '0';
                BInvert <= '1';
                Op      <= "10";
            end if;
        end if;
end process;
end behavioral;