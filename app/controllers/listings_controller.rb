class ListingsController < ApplicationController
    def index
       @listings = Listing.where(status: 'active')
    end

    def new
        @listing = Listing.new
        @stocks = Stock.all
        @sellers = User.all
    end

    def create
        @listing = Listing.create(listings_params)

        if @listing.verify_listing(params[:listing][:stock_id]) && @listing.save!
            flash[:notice] = "Listing was created successfully."
            redirect_to listings_path
        else
            flash[:alert] = "Cannot sell more shares than you own."
            redirect_to new_listing_path
        end
    end

    def show
        @listing = Listing.find(params[:id])
    end

    private
    def listings_params
        params.require(:listing).permit(:seller_id, :stock_id, :amount, :price)
    end

end
