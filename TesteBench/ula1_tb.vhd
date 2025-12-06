library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula1_tb is
end ula1_tb;

architecture sim of ula1_tb is

    -- Componente da sua ULA
    component ula1 is 
        port(
            op      : in STD_LOGIC_VECTOR(0 TO 1);
            A       : in STD_LOGIC;
            B       : in STD_LOGIC;
            Less    : in STD_LOGIC;
            Vem1    : in STD_LOGIC;
            Ainvert : in STD_LOGIC;
            Binvert : in STD_LOGIC;
            R       : out STD_LOGIC;
            Set     : out STD_LOGIC;
            Vai1    : out STD_LOGIC
        );
    end component;

    -- Sinais internos
    signal op_s      : STD_LOGIC_VECTOR(0 TO 1);
    signal A_s       : STD_LOGIC;
    signal B_s       : STD_LOGIC;
    signal Less_s    : STD_LOGIC;
    signal Vem1_s    : STD_LOGIC;
    signal Ainvert_s : STD_LOGIC;
    signal Binvert_s : STD_LOGIC;

    -- Saídas
    signal R_s    : STD_LOGIC;
    signal Set_s  : STD_LOGIC;
    signal Vai1_s : STD_LOGIC;

begin

    -- Instancia sua ULA
    UUT: ula1 
        port map(
            op      => op_s,
            A       => A_s,
            B       => B_s,
            Less    => Less_s,
            Vem1    => Vem1_s,
            Ainvert => Ainvert_s,
            Binvert => Binvert_s,
            R       => R_s,
            Set     => Set_s,
            Vai1    => Vai1_s
        );

    -- Processo de estímulos
    stim: process
    begin
        
        -- Valores iniciais
        A_s       <= '0';
        B_s       <= '1';   -- equivalente ao seu "I = 01"
        Ainvert_s <= '0';
        Binvert_s <= '0';
        Vem1_s    <= '0';
        Less_s    <= '0';

        -- SOMA
        op_s <= "10"; wait for 20 ns;

        -- AND
        op_s <= "00"; wait for 20 ns;

        -- OR
        op_s <= "01"; wait for 20 ns;

        -- NAND
        Ainvert_s <= '1';
        Binvert_s <= '1';
        op_s      <= "01"; wait for 20 ns;

        -- NOR
        op_s <= "00"; wait for 20 ns;

        -- SUBTRAÇÃO (A + ~B + 1)
        Ainvert_s <= '0';
        Binvert_s <= '1';
        Vem1_s    <= '1';
        op_s      <= "10"; wait for 20 ns;

        -- LESS
        Less_s <= '1';
        op_s   <= "11"; wait for 20 ns;
        Less_s <= '0';

        -- Termina simulação
        wait for 20 ns;
        assert false report "Fim da simulação." severity failure;

    end process;

end sim;
