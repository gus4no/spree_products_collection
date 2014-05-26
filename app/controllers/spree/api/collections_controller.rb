module Spree
  module Api
    class CollectionsController < Spree::Api::BaseController

      before_filter :find_collection, except: [:index, :create]

      def index
        @collections = Spree::Collection.ransack(params[:q]).result
        @collections = @collections.in_taxons(build_taxons_params) if params[:taxons]
        @collections.page(params[:page]).per(params[:per_page])
      end

      def show;end

      def create
        authorize! :create, Collection
        @collection = Spree::Collection.new(collection_params)
        if @collection.save
          respond_with(@collection, status: 201, default_template: :show)
        else
          invalid_resource!(@collection)
        end
      end

      def update
        authorize! :update, Collection
        if @collection.update_attributes(collection_params)
          respond_with(@collection, status: 201, default_template: :show)
        else
          invalid_resource!(@collection)
        end
      end

      def destroy
        authorize! :destroy, Collection
        @collection.destroy
        respond_with(@collection, status: 204)
      end

      private

      def build_taxons_params
        params[:taxons].split(",").map(&:to_i)
      end

      def find_collection
        @collection = Spree::Collection.find params[:id]
      end

      def permitted_collection_attributes
        [:name, :slug, :product_ids]
      end

      def collection_params
        params.require(:collection).permit(permitted_collection_attributes)
      end
    end
  end
end
