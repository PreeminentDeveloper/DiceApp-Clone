package com.dicemessager.dice

import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage


class MyFirebaseMessagingService : FirebaseMessagingService() {
    private val TAG = "MyFirebaseMessagingServ"

    override fun onNewToken(p0: String) {
        super.onNewToken(p0)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
        sendNotification(remoteMessage.notification!!.title!!, remoteMessage.notification!!.body!!)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun sendNotification(title: String, body: String) {
        val style: NotificationCompat.BigPictureStyle = NotificationCompat.BigPictureStyle()
        val defaultSound: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
        val intent = Intent(applicationContext, MainActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
        val pendingIntent: PendingIntent = PendingIntent.getActivity(applicationContext, 0, intent, 0)
        val notificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val NOTIFICATION_CHANNEL_ID = "101"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            @SuppressLint("WrongConstant") val notificationChannel = NotificationChannel(NOTIFICATION_CHANNEL_ID, "Notification", NotificationManager.IMPORTANCE_MAX)

            //Configure Notification Channel
            notificationChannel.description = "DiceApp Notification"
            notificationChannel.enableLights(true)
            notificationChannel.vibrationPattern = longArrayOf(0, 1000, 500, 1000)
            notificationChannel.enableVibration(true)
            notificationManager.createNotificationChannel(notificationChannel)
        }
        var notificationBuilder = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
            .setSmallIcon(R.drawable.d)
            .setContentTitle(title)
            .setAutoCancel(true)
            .setSound(defaultSound)
            .setContentText(body)
            .setContentIntent(pendingIntent)
            .setStyle(style)
            .setWhen(System.currentTimeMillis())
            .setPriority(Notification.PRIORITY_MAX)
        notificationManager.notify(1, notificationBuilder!!.build())
    }
}
