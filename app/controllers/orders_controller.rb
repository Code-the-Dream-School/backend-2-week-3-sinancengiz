class OrdersController < ApplicationController
   #The rescue_from statement says that if an exception of the specified type occurs, call the catch_not_found method.
   rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found 
   before_action :set_order, only: [:show, :edit, :update, :destroy]
   layout 'customer_layout'
   # GET /customers
   # GET /customers.json
   def index
     @orders = Order.all
   end
 
   # GET /customers/1
   # GET /customers/1.json
   def show
   end
 
   # GET /customers/new
   def new
     @order = Order.new
   end
 
   # GET /customers/1/edit
   def edit
   end
 
   # POST /customers
   # POST /customers.json
   def create
     #The create Method With Error Handling
     @order = Order.new(order_params)
     if @order.save
       flash.notice = "The corder record was created successfully."
       redirect_to @order
     else
       flash.now.alert = @order.errors.full_messages.to_sentence
       render :new  
     end
   end
 
   # PATCH/PUT /customers/1
   # PATCH/PUT /customers/1.json
   def update
     #The update Method With Error Processing
       if @order.update(order_params)
         flash.notice = "The order record was updated successfully."
         redirect_to @order
       else
         flash.now.alert = @order.errors.full_messages.to_sentence
         render :edit
       end
   end
 
   # DELETE /orders/1
   # DELETE /orders/1.json
   def destroy
     @order.destroy
     respond_to do |format|
       format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
       format.json { head :no_content }
     end
   end
 
   private
     # Use callbacks to share common setup or constraints between actions.
     def set_order
       @order = Order.find(params[:id])
     end
 
     # Only allow a list of trusted parameters through.
     def order_params
       params.require(:order).permit(:product_name, :product_count, :customer_id)
     end
 
     def catch_not_found(e)
   
       # The Rails.logger.debug statement writes an entry to the Rails log.  You will see it in the console.
       # The flash.alert statement takes the message from the exception and stores it in the flash object so that it can be displayed to the user.
       # The redirect_to statement puts up the index page again, so that the user does not see that other error page.

       Rails.logger.debug("We had a not found exception.")
       flash.alert = e.to_s
       redirect_to orders_path
     end
 
 end