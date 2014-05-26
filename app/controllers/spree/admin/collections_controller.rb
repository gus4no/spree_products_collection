module Spree
  module Admin
    class CollectionsController < ResourceController

      def index
        params[:q] ||= {}
        @search = Spree::Collection.ransack(params[:q])
        @collections = @search.result.page(params[:page]).per(params[:per_page])
      end

      private

      def find_resource
        @collection = Spree::Collection.find_by slug: params[:id]
      end

      def collection_params
        params.require(:collection).permit(:name, :slug, product_ids: [])
      end
    end
  end
end
