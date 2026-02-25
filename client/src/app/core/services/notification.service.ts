import { Injectable, signal } from '@angular/core';

export interface Notification {
  message: string;
  type: 'success' | 'error' | 'warning' | 'info';
}

@Injectable({
  providedIn: 'root',
})
export class NotificationService {
  private _notification = signal<Notification | null>(null);
  readonly notification = this._notification.asReadonly();

  success(message: string): void {
    this.show({ message, type: 'success' });
  }

  error(message: string): void {
    this.show({ message, type: 'error' });
  }

  warning(message: string): void {
    this.show({ message, type: 'warning' });
  }

  info(message: string): void {
    this.show({ message, type: 'info' });
  }

  clear(): void {
    this._notification.set(null);
  }

  private show(notification: Notification): void {
    this._notification.set(notification);
    setTimeout(() => this.clear(), 5000);
  }
}
