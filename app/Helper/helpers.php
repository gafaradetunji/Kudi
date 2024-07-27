<?php
use App\Models\User;
function getUserByMail($email, $context, $error = []) {
    $user = User::where('email', $email)->first();
    if(!$user){
        return $context->sendError('User not found', $error, 404);
    }
    return $user;
}
