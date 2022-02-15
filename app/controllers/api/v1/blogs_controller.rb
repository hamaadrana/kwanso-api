module Api
  module V1
    class BlogsController < ApplicationController

      def index
        @blogs = current_user.blogs.order('created_at DESC')
        render json: {status: 'Success', message: 'Loaded blogs', data: @blogs}, status: :ok
      end

      def search_blogs
        response = current_user.blogs.__elasticsearch__.search(
            query: {
                multi_match: {
                    query: params[:query],
                    fields: ['title']
                }
            }
        ).results

        render json: {
            results: response.results,
            total: response.total
        }
      end

      def show
        @blog = Blog.find(params[:id])
        render json: {status: 'Success', message: 'Loaded blogs', data: @blog}, status: :ok
      end

      def create
        @blog = current_user.blogs.new(blog_params)

        if @blog.save
          render json: {status: 'Success', message: 'Blog is saved', data: @blog}, status: :ok
        else
          render json: {status: 'Error', message: 'Blog is not saved', data: @blog.errors}, status: :unprocessable_entity
        end
      end

      def update
        @blog = Blog.find(params[:id])

        if @blog.update_attributes(blog_params)
          render json: {status: 'Success', message: 'Blog is updated', data: @blog}, status: :ok
        else
          render json: {status: 'Error', message: 'Blog is not updated', data: @blog.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @blog = Blog.find(params[:id])
        @blog.destroy

        render json: {status: 'Success', message: 'Blog successfully deleted', data: @blog}, status: :ok
      end

      private

      def blog_params
        params.require(:blog).permit(:title, :body)
      end

    end
  end
end