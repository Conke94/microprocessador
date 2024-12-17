library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
    port (   
        jump_en, wr_acumulador, wr_flag_zero, wr_flag_carry, wr_pc, wr_ram : out std_logic;
        clk, reset, flag_zero, flag_carry : in std_logic;
        operation: out unsigned(1 downto 0);
        last_adress : in unsigned(6 downto 0);
        adress_out, ram_address :  out unsigned(6 downto 0);
        instruction : in unsigned(15 downto 0);
        registrador : out unsigned(2 downto 0);
        wr_reg : out std_logic;
        state_out : out unsigned(1 downto 0)
    );  
 end entity;

 architecture a_controller of controller is
    component state_machine is
        port(
            clk, reset : in std_logic;
            state : out unsigned(1 downto 0)
        );
    end component;

    signal opcode: unsigned(3 downto 0);
    signal jump : std_logic;
    signal state : unsigned(1 downto 0);
    
    begin
        state_mach : state_machine PORT MAP(clk, reset, state);

        opcode <= instruction(3 downto 0);
        registrador <= instruction(8 downto 6);

        operation <= "00" when opcode = "0001" or opcode = "0010" else
                     "01" when opcode = "1001" or opcode = "1010" or opcode="1000" else
                     "00";

        jump <= '1' when opcode="1111" else '0'; 
        jump_en <= jump;

        adress_out <= last_adress + instruction(15 downto 9) when ((opcode = "0110" and flag_zero = '0') or (opcode = "0111" and flag_carry = '1')) else
                      instruction(15 downto 9) when jump = '1' else
                      last_adress + 1 when jump = '0';
                      
        wr_pc <= '1' when state = "10" else '0';
        wr_flag_zero <= '1' when ((opcode = "0001" or opcode = "0010" or opcode = "1001" or opcode = "1010" or opcode = "1000") and state="01") else '0';
        wr_flag_carry <= '1' when ((opcode = "0001" or opcode = "0010" or opcode = "1001" or opcode = "1010" or opcode = "1000") and state="01") else '0';

        wr_acumulador <= '1' when ((opcode = "0010" or opcode = "0001" or opcode = "1010" or opcode = "0101") and state = "01")  else '0';
        wr_reg <= '1' when opcode = "0011" or opcode = "0100" or opcode="1010" or opcode = "1011" else '0';
        state_out <= state;

        wr_ram <= '1' when opcode = "1100" else '0'; 
        ram_address <= instruction(15 downto 9);
    end architecture;