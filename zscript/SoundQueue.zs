class SoundQueue : StaticEventHandler
{
    ui Array<QueuedSound> queue;
    ui int waitTime;
    ui bool playing;

    override void UiTick()
    {
        if (queue.Size() == 0)
        {
            return;
        }
        if (playing)
        {
            if (waitTime > 0)
            {
                waitTime--;
            }
            else
            {
                S_StartSound(queue[0].sound, CHAN_VOICE, CHANF_UI|CHANF_NOPAUSE);
                waitTime = queue[0].pause;
                queue[0].Destroy();
                queue.Delete(0, 1);
                if (queue.Size() == 0)
                {
                    playing = false;
                }
            }
        }
    }

    ui static void Clear()
    {
        SoundQueue handler = SoundQueue(StaticEventHandler.Find("SoundQueue"));
        for (int i = 0; i < handler.queue.Size(); i++)
        {
            handler.queue[i].Destroy();
        }
        handler.queue.Clear();
    }

    ui static void AddSound(string sound, int pause)
    {
        SoundQueue handler = SoundQueue(StaticEventHandler.Find("SoundQueue"));
        handler.queue.push(QueuedSound.Create(sound, pause));
    }

    ui static void UnshiftSound(string sound, int pause)
    {
        SoundQueue handler = SoundQueue(StaticEventHandler.Find("SoundQueue"));
        handler.queue.Insert(0, QueuedSound.Create(sound, pause));
    }

    ui static void PlayQueue(int initialPause)
    {
        SoundQueue handler = SoundQueue(StaticEventHandler.Find("SoundQueue"));
        handler.waitTime = initialPause * 1000 / GameTicRate;
        handler.playing = true;
    }
}
