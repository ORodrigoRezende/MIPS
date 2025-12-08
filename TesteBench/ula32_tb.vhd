library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula32_tb is
end ula32_tb;

architecture sim of ula32_tb is

    -- Declaração do componente exatamente como sua entidade
    component ula32 is
        port(
            Ainvet  : in  STD_LOGIC;
            Binvert : in  STD_LOGIC;
            A       : in  STD_LOGIC_VECTOR (31 downto 0);
            B       : in  STD_LOGIC_VECTOR (31 downto 0);
            Op      : in  STD_LOGIC_VECTOR (1 downto 0);
            R       : out STD_LOGIC_VECTOR (31 downto 0);
            Zero    : out STD_LOGIC
        );
    end component;

    -- Sinais internos para conectar ao componente
    signal Ainvet  : std_logic := '0';
    signal Binvert : std_logic := '0';
    signal Op      : std_logic_vector(1 downto 0) := "00";
    signal A, B    : std_logic_vector(31 downto 0) := (others => '0');
    signal R       : std_logic_vector(31 downto 0);
    signal Zero    : std_logic;

begin

    -- Instanciação da Unidade Sob Teste (UUT)
    UUT: ula32
        port map(
            Ainvet  => Ainvet,
            Binvert => Binvert,
            A       => A,
            B       => B,
            Op      => Op,
            R       => R,
            Zero    => Zero
        );

    -- Processo de estímulos
    process
    begin
        -- Caso 1: Teste com A=10 e B=3
        A <= std_logic_vector(to_signed(10, 32));
        B <= std_logic_vector(to_signed(3, 32));
        
        -- Garante que inversores comecem desligados
        Ainvet <= '0';
        Binvert <= '0';

        -- Teste 1: AND (Op 00)
        Op <= "00"; 
        wait for 20 ns;

        -- Teste 2: OR (Op 01)
        Op <= "01"; 
        wait for 20 ns;

        -- Teste 3: SOMA (Op 10)
        Op <= "10"; 
        wait for 20 ns;

        -- Teste 4: SUBTRAÇÃO (Geralmente Op 10 ou 11 com Binvert ligado)
        -- Aqui ligamos o Binvert para simular A - B
        Binvert <= '1';
        Op <= "10"; -- Supondo que sua ULA use o somador para subtrair
        wait for 20 ns;

        -- Teste 5: SLT (Set on Less Than - Op 11)
        Op <= "11";
        wait for 20 ns;

        -- Caso 2: Teste de Zero (A=0, B=0)
        Ainvet <= '0';
        Binvert <= '0';
        A <= std_logic_vector(to_signed(0, 32));
        B <= std_logic_vector(to_signed(0, 32));
        
        -- Teste Soma 0+0
        Op <= "10"; 
        wait for 20 ns;
        
        -- Para a simulação
        assert false report "Fim da Simulação" severity failure;
        wait;
    end process;

end sim;