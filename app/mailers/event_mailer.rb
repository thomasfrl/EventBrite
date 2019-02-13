class EventMailer < ApplicationMailer
  default from: 'no-reply@event-brite-thomas.herokuapp.com'
 
  def event_email(attendance)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = attendance.user 
    @event = attendance.event 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'event-brite-thomas.herokuapp.com' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue à notre evènement !') 
  end

  def admin_email(attendance)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = attendance.user 
    @event = attendance.event 
    @admin = @event.administrator
    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'event-brite-thomas.herokuapp.com' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @admin.email, subject: 'Nouveau participant à votre evènement !') 
  end


end
