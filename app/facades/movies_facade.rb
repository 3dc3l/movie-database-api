class MoviesFacade

    attr_reader :params, :movie_params

    def initialize(params = nil, movie_params = nil)
        @params = params
        @movie_params = movie_params
      end
  

    def all_movies
        movies = Movie.order('created_at DESC');
            
        options = {
            :include => [ :genres, :casts],
            :methods => :get_image_url
        }

        return :json => movies.to_json(options)
    end

    def show

        movie = Movie.where(id: @params[:id]).first

        add_label_property(movie, 'genres')
        add_label_property(movie, 'casts')

        options = {
            :include => [ 
                :users, 
                :genres => {
                    :methods => :label
                }, 
                :casts => {
                    :methods => [:get_image_url, :label]
                }
            ],
            :methods => [:get_image_url]
        }
        
        return :json => movie.to_json(options)
    end

    def create
        movie = Movie.new(movie_params)
        #convert title to slug
        movie.slug = movie_params[:title].parameterize

        #add casts to movie
        if params[:cast_id]
            params[:cast_id].each do |cast|
                existing_cast = Cast.find_by_id(cast)
                movie.casts << existing_cast if existing_cast.present?
            end
        end

        #add genre
        if params[:genre_id]
            params[:genre_id].each do |genre|
                existing_genre = Genre.find_by_id(genre)
                movie.genres << existing_genre if existing_genre.present?
            end
        end
        
        if movie.save
            return :json => movie.to_json
        else
            return :json => {
                status: 'ERROR',
                message: 'Movie not saved',
                data: movie.errors
            }, status: :unprocessable_entity
        end
    end

    def update
        movie = Movie.find_by_id(params[:id])
        #convert title to slug
        movie.slug = params[:title].parameterize

        #remove existing casts and create new set
        movie.casts.clear
        if params[:cast_id]
            params[:cast_id].each do |cast|
                existing_cast = Cast.find_by_id(cast)
                movie.casts << existing_cast if existing_cast.present?
            end
        end

        movie.genres.clear
        #remove existing genre and create new set
         if params[:genre_id]
            params[:genre_id].each do |genre|
                existing_genre = Genre.find_by_id(genre)
                movie.genres << existing_genre if existing_genre.present?
            end
        end

        if movie.update(movie_params)
            return :json => movie.to_json
        else
            return :json => {
                status: 'ERROR',
                message: 'Movie not updated',
                data: movie.errors
            }, status: :unprocessable_entity
        end
    end

    private
        def add_label_property(movie, model_type)
            if model_type == 'genres'
                movie.genres.each do |item|
                    item.label = item.title
                end
            else
                movie.casts.each do |item|
                    item.label = item.first_name + " " + item.middle_name + " " + item.last_name
                end   
            end
        end
end