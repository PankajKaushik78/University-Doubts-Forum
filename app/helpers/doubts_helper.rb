module DoubtsHelper

    # Check author of doubt
    def doubt_author(doubt)
        user_signed_in? && current_user.id == doubt.user_id
    end

    # Check author of comment
    def comment_author(comment)
        user_signed_in? && current_user.id == comment.user_id
    end

    # Check author of answer
    def answer_author(answer)
        user_signed_in? && current_user.id == answer.user_id
    end
end
