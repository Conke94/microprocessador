library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_e_sub_tb is
end entity;

architecture a_soma_e_sub_tb of soma_e_sub_tb is
    component soma_e_sub
        port(
            x,y       :  in  unsigned(7 downto 0); -- vetor 8 bits
            soma,subt :  out unsigned(7 downto 0) -- vetor de 8 bits
        );
    end component;
    signal x, y, soma, subt : unsigned(7 downto 0);

    begin
        uut : soma_e_sub port map(
            x => x,
            y => y,
            soma => soma,
            subt => subt
        );
    
        process
            begin
                x <= "11111111";
                y <= "11111111";
                wait for 50 ns;

                wait;
        
    end process;

end architecture;