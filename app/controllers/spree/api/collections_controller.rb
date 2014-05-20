module Spree
  module Api
    class CollectionsController < Spree::Api::BaseController

      before_filter :find_collection, except: [:index, :create]

      def index
        @collections = Spree::Collection.all
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

      def find_collection
        @collection = Spree::Collection.find_by slug: params[:id]
      end

      def collection_params
        params.require(:collection).permit(:name, :slug)
      end
    end
  end
end
