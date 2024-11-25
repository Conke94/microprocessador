library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessador is
    port(
        clk, reset : in std_logic;
        ula_zero, ula_carry, jump_en : out std_logic
    );
end entity;

architecture a_microprocessador of microprocessador is 
    component banco is
        port(
        clk, reset, wr_en : in std_logic;
        reg_wr, reg_read : in unsigned(2 downto 0);
        data_in : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
    );
    end component;

    component ula is  
        port (   
        x,y : in unsigned(15 downto 0);
        out_a :  out unsigned(15 downto 0);
        operation : in unsigned(1 downto 0);
        flag_carry, flag_zero: out std_logic
    ); 
    end component;

    component reg16bits is
        port(
            clk, reset, wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    component rom is
        port( 
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(15 downto 0) 
         );
    end component;

    component pc is
        port(
            clk, reset, wr_en : in std_logic;
            data_in : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0)
        );
    end component;

    component controller is
        port (   
            jump_en : out std_logic;
            clk, reset : in std_logic;
            last_adress : in unsigned(6 downto 0);
            adress_out :  out unsigned(6 downto 0);
            instruction : in unsigned(15 downto 0);
            operation : out unsigned(1 downto 0);
            registrador : out unsigned(2 downto 0);
            state_out :  out unsigned(1 downto 0)
        );  
    end component;

    signal wr_en : std_logic;
    signal data_acumulador : unsigned(15 downto 0);
    signal state : unsigned(1 downto 0);
    signal wr_en_acumulador : std_logic;
    signal reg_wr : unsigned(2 downto 0);
    signal imm : unsigned(15 downto 0);
    signal opcode: unsigned(3 downto 0);
    signal operation: unsigned(1 downto 0);
    signal registrador : unsigned(2 downto 0);
    signal instruction : unsigned(15 downto 0);
    signal pc_in : unsigned(6 downto 0) := "0000000";
    signal endereco : unsigned(6 downto 0) := "0000000";
    signal ula_out : unsigned(15 downto 0) := "0000000000000000";
    signal operando : unsigned(15 downto 0) := "0000000000000000";
    signal acumulador_value : unsigned(15 downto 0) := "0000000000000000";
    signal valor_registrador : unsigned(15 downto 0) := "0000000000000000";
    
    begin
        program_counter : pc PORT MAP(clk, reset, wr_en => '1', data_in => pc_in, data_out => endereco);

        controller_unit : controller PORT MAP (
            clk => clk, 
            reset => reset, 
            last_adress => endereco, 
            adress_out => pc_in, 
            instruction => instruction,
            jump_en => jump_en,
            operation => operation,
            registrador => registrador,
            state_out => state
        );

        rom_main : rom PORT MAP (clk, endereco, dado => instruction);

        banco_registradores : banco PORT MAP (
            clk=>clk,
            reset=>reset, 
            wr_en=>wr_en, 
            reg_wr=>reg_wr, 
            reg_read=>registrador, 
            data_in=>imm,
            data_out=>valor_registrador
        );

        opcode <= instruction(3 downto 0);
        wr_en <= '1' when opcode = "0011" or opcode = "0100" or opcode="1010" else '0';
        operando <= imm when opcode = "0010" or opcode="1010" else valor_registrador;

        imm <= acumulador_value when opcode = "0100" else "000000000" & instruction(15 downto 9);
        reg_wr <= instruction(8 downto 6);

        ula_main : ula PORT MAP(
            operation=>operation, 
            x=>acumulador_value,
            y=>operando,
            out_a=>ula_out, 
            flag_zero=>ula_zero,
            flag_carry=>ula_carry
        );

        wr_en_acumulador <= '1' when ((opcode = "0010" or opcode = "0001" or opcode = "1010" or opcode = "0101") and state = "01")  else '0';
        data_acumulador <= valor_registrador when opcode = "0101" else ula_out;
        acumulador : reg16bits PORT MAP(clk => clk, reset => reset, wr_en => wr_en_acumulador, data_in => data_acumulador, data_out => acumulador_value);
end architecture;