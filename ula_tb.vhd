library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
    component ula
        port(   
            x,y       :  in  unsigned(15 downto 0);
            out_a :  out unsigned(15 downto 0);
            operation : in unsigned(1 downto 0);
            flag_zero: out std_logic
        );
    end component;

    signal x, y, out_a : unsigned(15 downto 0);
    signal operation : unsigned(1 downto 0);
    signal flag_zero : std_logic;

    begin
        uut : ula port map(
            x => x,
            y => y,
            out_a => out_a,
            operation => operation,
            flag_zero => flag_zero
        );
    
        process
            begin
                x <= "1111111111111111";
                y <= "1111111111111111";
                operation <= "00";
                wait for 50 ns;
                x <= "1111111111111111";
                y <= "1111111111111111";
                operation <= "01";
                wait for 50 ns;
                x <= "0000000000000000";
                y <= "0000000000000000";
                operation <= "00";
                wait for 50 ns;
                x <= "0000000000000000";
                y <= "0000000000000000";
                operation <= "01";
                wait for 50 ns;
                x <= "0000000000001000";
                y <= "0000000000000100";
                operation <= "00";
                wait for 50 ns;
                x <= "0000000000001000";
                y <= "0000000000000100";
                operation <= "01";
                wait for 50 ns;
                x <= "0000000000000100";
                y <= "0000000000001000";
                operation <= "00";
                wait for 50 ns;
                x <= "0000000000000100";
                y <= "0000000000001000";
                operation <= "01";
                wait for 50 ns;
                x <= "1010101010101010";
                y <= "0000000000000011";
                operation <= "10";
                wait for 50 ns;
                wait;
    end process;

end architecture;