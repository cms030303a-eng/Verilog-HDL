/* 1MHz 클록으로부터 1Hz 주파수의 클록을 생성하는 주파수 분주기 */

module freq_div (
   iCLK,      // 외부 기준 클록
   iRESETn,   // Active-Low 리셋 
   oMYCLK);   // 원하는 주파수의 클록

   /* ------------------------------------------------------------------ */
   /*  원하는 주파수 생성을 위한 파라미터 값 계산                        */
   /*                                                                    */ 
   /*  외부 클록의 주파수 : freq_ref = 1,000,000Hz (1㎒)                 */ 
   /*  원하는 클록의 주파수 : freq_myclk = 1㎐                           */
   /*  반주기 카운트 값 : VAL_CNT = freq_ref/(2*freq_myclk)              */
   /*                             = 500,000                              */
   /*  Val_CNT 저장에 필요한 비트 수를 확인하여 VAL_CNT를 파라미터 선언  */
   /*  example) localparam   VAL_CNT = 19'd500000                        */
   /* ------------------------------------------------------------------ */

   localparam   VAL_CNT = 32'd25000000;  // 반주기 카운트 값을 파라미터 선언
   localparam   WIDTH = 32;

   input               iCLK, iRESETn;
   output              oMYCLK;
	   
   reg	    [WIDTH-1:0] cnt_clk;
   reg                 myclk;
		
   assign   oMYCLK = myclk;

   always @(posedge iCLK or negedge iRESETn)  begin
      if (!iRESETn) begin 
         cnt_clk   <=  0;
         myclk     <=  0;
      end
      else if (cnt_clk == VAL_CNT - 1)  begin
         cnt_clk   <=  0;
         myclk     <=  ~myclk; 
      end
      else
         cnt_clk   <=  cnt_clk + 1;
   end
   	
endmodule