Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity Buzzer is
Port(
	CLK,Rstb : in std_logic;
	iS10,iF10,iS5,iF5 : in std_logic;
	oBuz : out std_logic
);
End Buzzer;

Architecture Behavioral of Buzzer is
	signal wBuz1,wBuz2 : std_logic := '0';
	signal wI1,wI2 : std_logic := '0';
	signal r1s : std_logic := '0';
	signal rCnt : std_logic_vector(24 downto 0);
	signal rCnt1,rCnt2 : std_logic := '0';
	signal wReS,wReF : std_logic := '0';
	signal num : std_logic_vector(1 downto 0) := "00";
Begin

	oBuz <= 	wBuz1 when wI1='1' else
				wBuz2 when wI2='1' else
				'0';
	
	u_BuzSF : Process(CLK,Rstb,wReS,wReF)
	Begin
		if(Rstb='0' or wReS='1' or wReF='1') then
			wI1 <= '0';
			wI2 <= '0';
		elsif(rising_edge(CLK)) then
			if(iS10='1' or iS5='1') then
				wI1 <= '1';
				wI2 <= '0';
			elsif(iF10='1' or iF5='1') then
				wI2 <= '1';
				wI1 <= '0';
			else
				wI1 <= wI1;
				wI2 <= wI2;
			end if;
		end if;
	end Process;
	
	u_rClk : Process(CLK,Rstb,wReS,wReF,wI1,wI2)
	Begin
		if(Rstb = '0' or wReS='1' or wReF='1') then
			rCnt <= (others => '0');
			r1s <= '0';
		elsif(rising_edge(CLK) and (wI1='1' or wI2='1')) then
			if(rCnt = 24999999) then
				rCnt <= (others => '0');
				r1s <= '1';
			else
				rCnt <= rCnt + 1;
				r1s <= '0';
			end if;
		else
			r1s <= r1s;
		end if;
	end Process;
	
	u_BuzStart : Process(CLK,Rstb,wI1,wReS)
	Begin
		if(Rstb='0' or wReS='1') then
			wBuz1 <= '0';
			rCnt1 <= '1';
			wReS <= '0';
		elsif(rising_edge(CLK) and wI1='1') then
			if(rCnt1='1' and wBuz1='0') then
				wBuz1 <= not wBuz1;
				rCnt1 <= '0';
				wReS <= '0';
			elsif(r1s='1' and rCnt1='0') then
				wBuz1 <= '0';
				wReS <= '1';
			else
				wBuz1 <= wBuz1;
				wReS <= wReS;
			end if;
		else
			wBuz1 <= wBuz1;
			wReS <= wReS;
		end if;
	end Process;
	
	u_BuzFinish : Process(CLK,Rstb,wI2,wReF)
	Begin
		if(Rstb='0' or wReF='1') then
			wBuz2 <= '0';
			rCnt2 <= '1';
			num <= (others => '0');
			wReF <= '0';
		elsif(rising_edge(CLK) and wI2='1') then
			if(rCnt2='1' and wBuz2='0') then
				wBuz2 <= not wBuz2;
				rCnt2 <= '0';
				wReF <= '0';
			elsif(r1s='1' and rCnt2='0') then
				num <= num + 1;
				if(num>1) then
					wBuz2 <= '0';
					wReF <= '1';
				else
					wBuz2 <= '1';
					wReF <= '0';
				end if;
			else
				wBuz2 <= wBuz2;
				wReF <= wReF;
			end if;
		else
			wBuz2 <= wBuz2;
			wReF <= wReF;
		end if;
	end Process;

End Behavioral;

