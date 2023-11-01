module mac (clk, reset_n, instruction, multiplier,
            multiplicand, stall, protect, result);
input clk;
input reset_n;
input [2:0] instruction;
input [15:0] multiplier;
input [15:0] multiplicand;
input stall;
output reg [7:0] protect;
output reg [31:0] result;
reg [31:0]queue[2:0];
reg [15:0] Multiplier;
reg [15:0] Multiplicand;
reg [39:0] temp;
reg [39:0] temp2;
reg [1:0] notice;
reg[1:0] notice1;

/* 	for first part of class
reg [39:0] queue[1:0];//the output queue
reg [39:0] last_output;
reg [1:0] counter;
reg [1:0] counter2;
*/
integer i;//just for for loop

always@(posedge clk or negedge reset_n)
begin
    if (reset_n == 1'b0)
    begin
        protect[7:0] = 8'h0;
        result[31:0] = 32'h0;

    end
    else
    begin
        // reset_n == 1'b1

        Multiplier = multiplier;	// new multiplier`
        Multiplicand = multiplicand;// new multiplicand

        if (instruction == 3'b000 || instruction == 3'b100)
        begin
            temp = 40'd0;
            result[31:0]=32'h0;
            protect[7:0]=8'h0;
        end
        else if (instruction == 3'b001)
        begin
            {protect[7:0],result[31:0]}=Multiplier*Multiplicand;// 16-bit x 16-bit
            notice = 2'd0;
            // reset negative count

            if (Multiplier[15] == 1'b1)
            begin
                // negative number
                notice=notice+1;// ...
            end

            if (Multiplicand[15] == 1'b1)
            begin
                // negative number
                notice=notice+1;// ...

            end

            temp = {protect[7:0],result[31:0]};

            if (notice%2 == 1)
                // negative result
                temp=~temp+1;
            // 2's complement

            for (i=32; i<40; i=i+1)
                temp[i]=temp[31];
            // sign extension

            // current result is stored in temp
        end
        else if (instruction == 3'b010)
        begin
            temp2 = temp;

            // temp: temporary multiplication result
            // temp2: temporary mac result
            notice = 2'd0;

            if (Multiplier[15] == 1'b1)
            begin
                notice=notice+1;
                Multiplier=~Multiplier+1;
            end

            if (Multiplicand[15] == 1'b1)
            begin
                notice=notice+1;
                Multiplicand=~Multiplicand+1;
            end

            temp[31:0] = temp2;
            {protect[7:0],result[31:0]}=Multiplicand*Multiplier;
            if (notice%2 == 1)
                {protect[7:0],result[31:0]}=~{protect[7:0],result[31:0]}+1;
            {protect[7:0],result[31:0]}=temp2+{protect[7:0],result[31:0]};

            for (i=32; i<40; i=i+1)
                temp[i]=temp[31];

            temp = {protect[7:0],result[31:0]};

            // current result is stored in temp
            result=temp;
        end
        else if (instruction == 3'b011)
        begin
            // saturation16
            if (temp > 40'h007fffffff && temp[39] == 1'b0)
                temp[31:0] = 32'h7FFFFFFF;
            else if (temp < 40'hff80000000 && temp[39] == 1'b1)
                temp[31:0] = 32'h80000000;

            // current result is stored in temp
        end
        else if (instruction == 3'b101)
        begin
            temp = 40'd0;



            // temp: temporary multiplication result
            // temp2: temporary mac result
            notice = 2'd0;
            notice1=2'd0;
            if (Multiplier[15] == 1'b1)
            begin
                notice=notice+1;
                Multiplier[15:8]=~Multiplier[15:8]+1;
            end
            if (Multiplier[7] == 1'b1)
            begin
                notice1=notice1+1;
                Multiplier[7:0]=~Multiplier+1;
            end

            if (Multiplicand[15] == 1'b1)
            begin
                notice=notice+1;
                Multiplicand[15:8]=~Multiplicand[15:8]+1;
            end
            if (Multiplicand[7] == 1'b1)
            begin
                notice=notice+1;
                Multiplicand[7:0]=~Multiplicand[7:0]+1;
            end

            {protect[3:0],result[15:0]}=Multiplicand[7:0]*Multiplier[7:0];
            {protect[7:4],result[31:16]}=Multiplicand[15:8]*Multiplier[15:8];
            if (notice%2 == 1)
            begin
                {protect[3:0],result[15:0]}=~{protect[3:0],result[15:0]}+1;
                {protect[7:4],result[31:16]}=~{Multiplicand[15:8]*Multiplier[15:8]}+1;
            end
            temp={protect[7:4],result[31:16],protect[3:0],result[15:0]};





            // current result is stored in temp



            // current result is stored in temp
        end
        else if (instruction == 3'b110)
        begin
            temp2=temp;
            temp = 40'd0;
            notice = 2'd0;
            notice1=2'd0;
            if (Multiplier[15] == 1'b1)
            begin
                notice=notice+1;
                Multiplier[15:8]=~Multiplier[15:8]+1;
            end
            if (Multiplier[7] == 1'b1)
            begin
                notice1=notice1+1;
                Multiplier[7:0]=~Multiplier+1;
            end

            if (Multiplicand[15] == 1'b1)
            begin
                notice=notice+1;
                Multiplicand[15:8]=~Multiplicand[15:8]+1;
            end
            if (Multiplicand[7] == 1'b1)
            begin
                notice=notice+1;
                Multiplicand[7:0]=~Multiplicand[7:0]+1;
            end

            {protect[3:0],result[15:0]}=temp[19:0]+Multiplicand[7:0]*Multiplier[7:0];
            {protect[7:4],result[31:16]}=temp[39:20]+Multiplicand[15:8]*Multiplier[15:8];
            if (notice%2 == 1)
            begin
                {protect[3:0],result[15:0]}=temp[19:0]+(~{protect[3:0],result[15:0]}+1);
                {protect[7:4],result[31:16]}=temp[39:20]+(~{Multiplicand[15:8]*Multiplier[15:8]}+1);
            end
            temp={protect[7:4],result[31:16],protect[3:0],result[15:0]};





            // current result is stored in temp




            // current result is stored in temp
        end
        else if (instruction == 3'b111)
        begin
            // saturation16
            if (temp > 20'h07fff && temp[39] == 1'b0)
                temp[31:0] = 16'h7FFF;
            else if (temp < 20'hf8000 && temp[39] == 1'b1)
                temp[31:0] = 16'h8000;

            // current result is stored in temp
        end

        if (stall == 1'b0)
        begin
            //{protect, result} = temp;

            result=queue[0];
            queue[0]=queue[1];
            queue[1]={temp[35:20],temp[15:0]};
        end
        else
        begin
            queue[1]=queue[0];

        end

    end
end
endmodule
