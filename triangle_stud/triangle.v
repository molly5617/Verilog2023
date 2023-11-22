`timescale 1ns/10ps
module triangle (clk, reset, nt, xi, yi, busy, po, xo, yo);
input clk, reset, nt;
input [2:0] xi, yi;
output reg busy, po;
output reg [2:0] xo, yo;

reg [1:0] cnt;
// the number of input points
reg [2:0] x1, y1, x2, y2, x3, y3;
integer i, j;

always@(posedge clk or posedge reset)
begin
    if (reset == 1'b1)
    begin
        i=0;
        j=0;
        cnt=0;
        x1=0;
        y1=0;
        x2=0;
        y2=0;
        x3=0;
        y3=0;

        xo=0;
        yo=0;
        po=0;
        cnt = 2'd0;
    end
    else
    begin // reset == 1'b0;
        if (nt == 1'b1)
        begin
            x1=xi;
            y1=yi;
            cnt = 2'd2;
        end
        else
        begin // nt == 1'b0;
            if (cnt == 2'd2)
            begin
                x2=xi;
                y2=yi;
                cnt = cnt-1'b1;
            end
            else if (cnt == 2'd1)
            begin
                x3=xi;
                y3=yi;
                cnt = cnt-1'b1;
                po=1;
            end
            else if (cnt == 2'd0 && po == 1'b1)
            begin
                //start to calculate
                if (x2 > x1)
                begin
                    for (i=y1+1'b1;i<y3;i=i+1)
                    begin
                        for (j=x1;j<x2;j=j+1)
                        begin
                            if((j-x1)/(i-y1)-(x2-x1)/(y2-y1)==0)
                            begin
                                xo=j;
                                yo=i;
                            end
                            else if(((i-y1)/(j-x1))>((y3-y2)/(x3-x2))&&((i-y1)/(j-x1))<((y2-y1)/(x2-x1)))
                            begin
                                xo=j;
                                yo=i;
                            end
                        end
                    end

                    po = 1'b0;
                    busy = 1'b0;
                end
                else
                begin
                    // x2 < x1
                    for (i=y1+1'b1;i<y3;i=i+1)
                    begin
                        for (j=x2;j<x1;j=j+1)
                        begin
                            if((j-x1)/(i-y1)-(x2-x1)/(y2-y1)==0)
                            begin
                                xo=j;
                                yo=i;
                            end
                            else if(((i-y1)/(j-x1))<((y3-y2)/(x3-x2))&&((i-y1)/(j-x1))>((y2-y1)/(x2-x1)))
                            begin
                                xo=j;
                                yo=i;
                            end
                        end
                    end

                    po = 1'b0;
                    busy = 1'b0;
                end
            end
        end
    end
end

endmodule
