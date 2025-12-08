library IEEE;
use IEEE.std_logic_1164.all;

entity flipflopd_tb is
end flipflopd_tb;

architecture sim of flipflopd_tb is

    -- Declaração do componente atualizada para sua entidade 'flipflod'
    component flipflopd is
        port(
            D      : in  STD_LOGIC;
            Clear  : in  STD_LOGIC;
            Preset : in  STD_LOGIC;
            Enable : in  STD_LOGIC;
            CLK    : in  STD_LOGIC;
            Q      : out STD_LOGIC
        );
    end component;

    -- Sinais internos ajustados
    signal D, Clear, Preset, Enable, CLK, Q : std_logic := '0';

begin

    -- Conexão (Port Map) atualizada
    UUT: flipflopd
        port map(
            D      => D,
            Clear  => Clear,
            Preset => Preset,
            Enable => Enable,
            CLK    => CLK,
            Q      => Q
        );

    stim: process
    begin
        -- Inicialização
        CLK <= '0'; 
        Clear <= '0'; 
        Preset <= '0'; 
        Enable <= '0'; 
        D <= '0';
        wait for 10 ns;

        -- 1. Teste de Escrita (Enable=1, Borda de Descida)
        CLK <= '1'; wait for 10 ns; -- Subida
        Enable <= '1'; D <= '1';    -- Prepara dados
        CLK <= '0'; wait for 10 ns; -- Descida (Grava 1 em Q)

        -- 2. Teste de Retenção (Enable=0)
        CLK <= '1'; wait for 10 ns;
        Enable <= '0'; D <= '0';    -- Muda D para 0, mas desativa Enable
        CLK <= '0'; wait for 10 ns; -- Descida (Q deve manter 1)

        -- 3. Teste de Clear (Assíncrono)
        CLK <= '1'; wait for 10 ns;
        Clear <= '1';               -- Ativa Clear
        wait for 10 ns;             -- Q deve ir para 0 imediatamente
        
        -- Finaliza simulação
        wait;
    end process;

end sim;