module Admin
  class SignedUrlsController < BaseController
    before_action :set_signed_url, only: [:show, :edit, :update, :destroy]

    # GET /signed_urls
    # GET /signed_urls.json
    def index
      @signed_urls = SignedUrl.all
    end

    # GET /signed_urls/1
    # GET /signed_urls/1.json
    def show
    end

    # GET /signed_urls/new
    def new
      @stream = Stream.find(params[:short_url_key])
      redirect_to streams_path, alert: "Must pass the Stream to the NEW action" if @stream.nil?

      attribs = {
        stream_id: @stream.short_url_key,
        short_path: SecureRandom.hex(10),
        expires_in: ENV.fetch(SIGNING_EXPIRES_IN).to_i,
      }
      @signed_url = SignedUrl.new(attribs)
    end

    # GET /signed_urls/1/edit
    def edit
      @stream = Stream.find(@signed_url.stream_id)
    end

    # POST /signed_urls
    # POST /signed_urls.json
    def create
      @signed_url = SignedUrl.new(signed_url_params)

      respond_to do |format|
        if @signed_url.save
          format.html { redirect_to admin_signed_url_path(@signed_url), notice: 'Signed url was successfully created.' }
          format.json { render :show, status: :created, location: @signed_url }
        else
          format.html { render :new }
          format.json { render json: @signed_url.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /signed_urls/1
    # PATCH/PUT /signed_urls/1.json
    def update
      respond_to do |format|
        if @signed_url.update(signed_url_params)
          format.html { redirect_to admin_signed_url_path(@signed_url), notice: 'Signed url was successfully updated.' }
          format.json { render :show, status: :ok, location: @signed_url }
        else
          format.html { render :edit }
          format.json { render json: @signed_url.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /signed_urls/1
    # DELETE /signed_urls/1.json
    def destroy
      @signed_url.destroy
      respond_to do |format|
        format.html { redirect_to admin_signed_urls_url, notice: 'Signed url was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_signed_url
        @signed_url = SignedUrl.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def signed_url_params
        params.require(:signed_url).permit(:email, :token, :stream_id, :expires_in, :short_path, :used_at, :generated_at)
      end
  end
end
