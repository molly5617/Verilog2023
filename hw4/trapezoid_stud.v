`timescale 1ns/10ps
module trapezoid (clk, reset, nt, xi, yi, busy, po, xo, yo);
input clk, reset, nt;
input [7:0] xi, yi;
output reg busy, po;
output reg [7:0] xo, yo;

reg [7:0] xul, yu, xur, xdl, yd, xdr;
reg [7:0] xl, xr;

reg [1:0] counter;
integer i, j;

always@(posedge clk, posedge reset)
begin
    if (reset == 1'b1)
    begin
        busy=0;
        po=0;
    end
    else
    begin
        // reset == 1'b0
        if (nt == 1'b1)
        begin
            busy = 1'b1;
            // the 1st coordinate
            // make all the 2's complement
            // coordinates positive
            xul = xi + 8'h80;
            yu = yi + 8'h80;
            // for the remaining three coordinates
            counter = 2'd3;
        end
        else if (busy == 1'b1)
        begin
            if (counter == 2'd3)
            begin
                // the 2nd coordinate
                xur=xi+8'h80;
                yu=yi+8'h80;
            end
            else if (counter == 2'd2)
            begin
                // the 3rd coordinate
                xdl=xi+8'h80;
                yd=yi+8'h80;
            end
            else if (counter == 2'd1)
            begin
                // the 4th coordinate
                xdr=xi+8'h80;
                yd=yi+8'h80;
            end
            else if (counter == 2'd0)
            begin
                // start compute and output
                po = 1'b1;
                #5;

                xl = xdl;
                xr = xdr;

                for (i=yd; i<=yu; i=i+1'b1)
                begin
                    for (j=xl; j<=xr; j=j+1'b1)
                    begin
                        ...
                            #10;
                    end

                    // for upper xl
                    if (xul >= xdl)
                        ...
                            else
                            begin
                                ...
                                end

                            // for upper xr
                            if (xur >= xdr)
                                ...
                                else
                                begin
                                    ...
                                    end
                            end
                            po = 1'b0;
                #5;
                busy = 1'b0;
            end
        end
    end
end // always
endmodule
