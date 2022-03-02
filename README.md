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
    
    favorites
        user_id
        movie_id
    
    reviews
        user_id (where is_admin == 0)
        movie_id
        content
        star

    users
    

relationships
    movies - genres | many to many     (Pivot: genres_movies)
    movies - casts | many to many       (Pivot: casts_movies)
    movie - favorites | one - many
    movie -reviews | one - many
    user - reviews | one - many

==============================================================================================================
TODO
    - frontend api
        Pagecontroller
    - frontend development
==============================================================================================================
Done
    ALL API for CMS
===================================================================================================================
REMINDER

    show user api if the token is valid
    

add to favorites

    ADD

    click add fav
        api call - user_id, movie_id

        find favorite where user_id and movie_id
            if exists
                remove
            else 
                add

    get movies with favorite
        params user_id
            if user_id
                find favorites by user_Id

                    movies == test 


        movies with favorites
        favorites->user_id == this.$auth.user.id



        