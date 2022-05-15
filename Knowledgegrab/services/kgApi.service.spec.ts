import { TestBed } from '@angular/core/testing';

import { KgapiserviceService } from './kgApi.service';

describe('KgapiserviceService', () => {
  let service: KgapiserviceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(KgapiserviceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
