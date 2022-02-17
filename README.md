tbl & fields
    movies
        title
        release_year
        thumbnail_url
        genre (other)
        casts (other)
    genre
        title

    casts
        first_name
        middle_name
        last_name
        stage_name
    
    favorates
        user_id
        movie_id
    
    reviews
        user_id (where is_admin == 0)
        movie_id
        content
        star

    users
    

relationships
    movies - genres | many to many     (Pivot: movie_genre)
    movies - casts | many to many       (Pivot: movie_cast)
    movie - favorites | one - many
    movie -reviews | one - many
    user - reviews | one - many




        