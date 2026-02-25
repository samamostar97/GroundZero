import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { ApiError } from '../models/api-error.model';
import { NotificationService } from '../services/notification.service';

export const errorInterceptor: HttpInterceptorFn = (req, next) => {
  const notification = inject(NotificationService);

  return next(req).pipe(
    catchError((response) => {
      const error: ApiError = response.error;

      switch (response.status) {
        case 400:
          if (error?.errors) {
            const messages = Object.values(error.errors).flat();
            notification.error(messages.join('\n'));
          } else {
            notification.error(error?.error ?? 'Bad request.');
          }
          break;

        case 401:
          notification.error(error?.error ?? 'Unauthorized. Please log in.');
          break;

        case 403:
          notification.error(error?.error ?? 'You do not have permission.');
          break;

        case 404:
          notification.error(error?.error ?? 'Resource not found.');
          break;

        case 409:
          notification.error(error?.error ?? 'Conflict occurred.');
          break;

        default:
          notification.error('An unexpected error occurred.');
          break;
      }

      return throwError(() => response);
    })
  );
};
