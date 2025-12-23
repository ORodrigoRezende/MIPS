--------------------------------------------------------------------------------



-- Teste para rodar no site EDA playground


--------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY MIPS_32bits_tb IS
END MIPS_32bits_tb;
 
ARCHITECTURE behavior OF MIPS_32bits_tb IS 
 
COMPONENT mips
PORT(
     Clk           : IN  std_logic;
     Inicializar   : IN  std_logic;
     DebugEndereco : IN  std_logic_vector(31 downto 0);
     DebugPalavra  : OUT std_logic_vector(31 downto 0)
);
END COMPONENT;

    
   signal DebugEndereco : std_logic_vector(31 downto 0) := (others => '0');
   signal Clock         : std_logic := '0';
   signal Inicializar   : std_logic := '0';
   signal DebugPalavra  : std_logic_vector(31 downto 0);

   constant Clock_period : time := 4 ns;

BEGIN
uut: mips PORT MAP (
   Clk           => Clock,
   Inicializar   => Inicializar,
   DebugEndereco => DebugEndereco,
   DebugPalavra  => DebugPalavra
);


   stim_proc: process
   begin
   
      Clock <= '1'; wait for Clock_period/2;
   Inicializar <= '1';
   wait for 1 ns;
   Inicializar <= '0';
   wait for 1 ns;
      Clock <= '0'; wait for Clock_period/2;


        		for j in 0 to 9 loop
                  for i in 0 to 7 loop
                    Clock <= '0'; wait for Clock_period/2;
                    Clock <= '1'; wait for Clock_period/2;
                  end loop;
				  DebugEndereco <= std_logic_vector(to_unsigned(j*4,32));
			    end loop;


      wait;
   end process;

END;