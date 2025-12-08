library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity portaor32 is port (
    E : in  STD_LOGIC_VECTOR (0 to 31);
    S : out  STD_LOGIC
);
end portaor32;

architecture Behavioral of portaor32 is
    signal primeira_camada : STD_LOGIC_VECTOR (0 to 7);
    signal segunda_camada   : STD_LOGIC_VECTOR (0 to 1);
begin
    gen_primeira_camada: for i in 0 to 7 generate
        primeira_camada(i) <= E(i*4) or E(i*4 + 1) or E(i*4 + 2) or E(i*4 + 3);
    end generate;

    gen_segunda_camada: for j in 0 to 1 generate
        segunda_camada(j) <= primeira_camada(j*4) or primeira_camada(j*4 + 1) or 
                             primeira_camada(j*4 + 2) or primeira_camada(j*4 + 3);
    end generate;

    S <= segunda_camada(0) or segunda_camada(1);
end Behavioral;