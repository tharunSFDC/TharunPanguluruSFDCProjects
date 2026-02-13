import { LightningElement, api } from 'lwc';
import CAR_HUB_PLACEHOLDER_IMAGE from '@salesforce/resourceUrl/placeholder';

export default class Placeholdercmp extends LightningElement {
    @api message;
    placeholderImage=CAR_HUB_PLACEHOLDER_IMAGE;
}