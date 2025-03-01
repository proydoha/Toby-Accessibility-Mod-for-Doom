class QueuedSound
{
    string sound;
    int pause;

    static QueuedSound Create(string sound, int pause)
    {
        QueuedSound newSound = new("QueuedSound");
        newSound.sound = sound;
        if (pause >= 0)
        {
            newSound.pause = pause * 1000 / GameTicRate;
        }
        else
        {
            newSound.pause = S_GetLength(sound) * 1000 / GameTicRate;
        }
        return newSound;
    }
}
