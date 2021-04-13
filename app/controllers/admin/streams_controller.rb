module Admin
  class StreamsController < BaseController
    # before_action :set_stream, only: [:show, :edit, :update, :destroy]

    # GET /admin/streams
    # GET /admin/streams.json
    def index
      @streams = Stream.all
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_stream
        @stream = Stream.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def stream_params
        params.require(:stream).permit(:title, :description, :video_id, :signed_token, :short_url_key, :width, :height, :max_width)
      end
  end
end
